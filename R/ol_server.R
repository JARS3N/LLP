
ol_server<-function(){
#this is hideous and I will go back and clean it up and such,just want to have it updated to working version now
  library(shiny)
  library(XML)
  library(asyr)
  library(outliers)
  library(ggplot2)
  library(ggthemes)
  library(dplyr)

  plot_title_logic <- function(a, x) {
    #a is input$exp
    #b is nfl
    #x is unique(B$fl)
    b <- length(x)
    c('Outlier_Analysis', x, a, a)[c(nchar(a) == 0 && b != 1,
                                     nchar(a) == 0 && b == 1,
                                     nchar(a) > 0 && b == 1,
                                     nchar(a) > 0 && b != 1)]
  }

  plot_logics <- function(nfl) {
    list(c(T, T, T, T), c(T, T, F, F))[[(nfl == 1) + 1]]
  }

  data_logics <- function(nfl) {
    list(c(T, T, T), c(T, T, F))[[(nfl == 1) + 1]]
  }

  file_out_logic <- function(u) {
    # u is input$exp==""
    c(u, 'outlier_analysis')[(nchar(u) == 0) + 1]
  }






  plot_func <- function(i) {
    list(function(x, gg_plot_title) {
      ggplot(x, aes(grade, percent)) +
        geom_bar(aes(fill = grade), stat = 'identity') +
        theme_bw() +
        scale_fill_tableau() +
        geom_text(
          data = x,
          aes(
            label = paste0(round(percent, 3), "%"),
            x = grade,
            y = percent
          ),
          position = position_dodge(width = 0.8),
          vjust = -0.6
        ) +
        ggtitle(gg_plot_title)
    }, function(x, gg_plot_title) {
      ggplot(x, aes(O2)) +
        geom_vline(
          xintercept = 152,
          alpha = .5,
          col = 'blue',
          linetype = 2
        ) +
        geom_vline(
          xintercept = 152 + c(5,-5),
          col = 'green',
          alpha = .5,
          linetype = 2
        ) +
        geom_vline(
          xintercept = 152 + c(10,-10),
          col = 'orange',
          alpha = .5,
          linetype = 2
        ) +
        geom_vline(
          xintercept = 152 + c(20,-20),
          col = 'red',
          alpha = .5,
          linetype = 2
        ) +
        theme_light() +
        xlab('mmHg O2') +
        geom_density(col = 'darkgray',
                     fill = 'lightgray',
                     alpha = .75) +
        ggtitle(gg_plot_title)
    },
    function(x, gg_plot_title) {
      ggplot(x, aes(grade, percent)) +
        geom_bar(aes(fill = grade), stat = 'identity') +
        theme_bw() +
        scale_fill_tableau() +
        geom_text(
          data = x,
          aes(
            label = paste0(round(percent, 3), "%"),
            x = grade,
            y = percent
          ),
          position = position_dodge(width = 0.8),
          vjust = -0.6
        ) +
        ggtitle(gg_plot_title) +
        facet_wrap(~ Lot + sn,
                   nrow = det_nrows(length(unique(x$fl))),
                   labeller = label_wrap_gen(multi_line = FALSE))
    },
    function(x, gg_plot_title) {
      ggplot(x, aes(O2)) +
        geom_vline(
          xintercept = 152,
          alpha = .5,
          col = 'blue',
          linetype = 2
        ) +
        geom_vline(
          xintercept = 152 + c(5,-5),
          col = 'green',
          alpha = .5,
          linetype = 2
        ) +
        geom_vline(
          xintercept = 152 + c(10,-10),
          col = 'orange',
          alpha = .5,
          linetype = 2
        ) +
        geom_vline(
          xintercept = 152 + c(20,-20),
          col = 'red',
          alpha = .5,
          linetype = 2
        ) +
        theme_light() +
        xlab('mmHg O2') +
        geom_density(col = 'darkgray',
                     fill = 'lightgray',
                     alpha = .75) +
        ggtitle(gg_plot_title) +
        facet_wrap(~ Lot + sn,
                   nrow = det_nrows(length(unique(x$fl))),
                   labeller = label_wrap_gen(multi_line = FALSE))
    })[[i]]
  }


  data_suffix <- c("_data_unsummarized.csv",
                   "_data_summarized.csv",
                   "_data_summarized_by_file.csv")

  plot_suffix <- c(
    "_grades_barplot.png",
    "_mmHgO2_densityplot.png",
    "_grades_barplot_by_sn.png",
    "_mmHgO2_densityplot_byfile.png"
  )

  shinyServer(function(input, output) {
    observeEvent(input$file, {
      B <<-
        lapply(input$file$datapath, asyr::new) %>%
        lapply(., function(a) {
          a$assay <- "outlier"
          a$calc_o2_lvl()
          a$levels %>%
            group_by(Well) %>%
            mutate(deltaO2 = O2 - 152) %>%
            summarise(.,
                      mxo2 = max(abs(deltaO2)),
                      grade = grade_ox(mxo2),
                      O2 = O2[abs(deltaO2) == max(abs(deltaO2))][1]) %>%
            mutate(
              .,
              Lot = paste0(a$type, a$lot),
              sn = a$sn,
              fl = a$file
            )

        }) %>%
        dplyr::bind_rows()




      D1 <<-
        group_by(B, grade) %>% count() %>% ungroup() %>% mutate(., percent = n /
                                                                  sum(n) * 100)
      D2 <<-
        group_by(B, grade, Lot, sn) %>% count()  %>% ungroup() %>% group_by(Lot, sn) %>%
        mutate(., percent = n / sum(n) * 100) %>% ungroup()

      outlier_count <- group_by(D2, Lot, sn) %>%
        mutate(ol = o2_binary(grade)) %>%
        summarise(., n = sum(ol))


      data_list <<- list(B, D1, D2)

      data_ind <- c(2, 1, 3, 1)
      output$olplot <- renderPlot({
        file_out <- file_out_logic(input$exp)

        if (input$exp == "") {
          gg_plot_title <- basename(unique(B$fl))
        } else{
          gg_plot_title <- input$exp
        }



        plot_cond <- c(
          input$ptype != "Density" & input$group == "All",
          input$ptype == "Density" & input$group == "All",
          input$ptype != "Density" & input$group != "All",
          input$ptype == "Density" & input$group != "All"
        )

        plot_index <- c(1:4)[plot_cond]

        plot_data <- plot_func(plot_index)

        plot_data(data_list[[data_ind[plot_cond]]], gg_plot_title)



      })

      output$table <- renderDataTable(D1, options = list(dom = 't'))

    })


    output$export <- downloadHandler(filename <- function() {
      paste0(input$exp, ".zip")
    },

    content <- function(file) {
      nfl <- length(unique(B$fl))
      plot_logic <- plot_logics(nfl)
      data_logic <- plot_logics(nfl)
      gg_plot_title <-
        plot_title_logic(input$exp, basename(unique(B$fl)))
      data_ind <- c(2, 1, 3, 1)
      # print("start plot data")
      plot_data <- Map(
        function(x, y, z) {
          x(y, z)
        },
        x = lapply(1:4, plot_func),
        y = data_list[data_ind],
        z = rep(gg_plot_title, 4)
      )
      print("plot_data end")
      file_out <- file_out_logic(input$exp)
      write.csv(outlier_count,
                paste0(input$exp, "_outlier_count.csv"),
                row.names = F)

      csv_names <- paste0(file_out, data_suffix[data_logic])
      plot_names <- paste0(file_out, plot_suffix[plot_logic])

      #write files
      print('start data write')
      datawrite <<- Map(function(x, y) {
        write.csv(x, y, row.names = FALSE)
      },
      x = data_list[data_logic],
      y = csv_names)
      # print('start plot write')
      plotwrite <<- Map(function(x, y) {
        ggsave(x, y, width = 10, height = 6)
      },
      x = plot_names,
      y = plot_data[plot_logic])
      # print("end data write")
      if (input$copy_asyrs == "Yes") {
        file.copy(input$file$datapath, getwd())
        file.rename(basename(input$file$datapath), input$file$name)
      }
      files_to_zip <- list.files(pattern = "png|csv|asyr")
      zip_name <- paste0(input$exp, ".zip")
      utils::zip(zip_name, files_to_zip)
      file.copy(zip_name, file)
      sapply(c(files_to_zip, zip_name), unlink)
    },
    contentType = "application/zip")


  })
}
