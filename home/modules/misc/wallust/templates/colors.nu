  let base00 = "{color0}" # Default Background
    let base01 = "{color1}" # Lighter Background (Used for status bars, line number and folding marks)
    let base02 = "{color2}" # Selection Background
    let base03 = "{color3}" # Comments, Invisibles, Line Highlighting
    let base04 = "{color4}" # Dark Foreground (Used for status bars)
    let base05 = "{color5}" # Default Foreground, Caret, Delimiters, Operators
    let base06 = "{color6}" # Light Foreground (Not often used)
    let base07 = "{color7}" # Light Background (Not often used)
    let base08 = "{color8}" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    let base09 = "{color9}" # Integers, Boolean, Constants, XML Attributes, Markup Link Url
    let base0a = "{color10}" # Classes, Markup Bold, Search Text Background
    let base0b = "{color11}" # Strings, Inherited Class, Markup Code, Diff Inserted
    let base0c = "{color12}" # Support, Regular Expressions, Escape Characters, Markup Quotes
    let base0d = "{color13}" # Functions, Methods, Attribute IDs, Headings
    let base0e = "{color14}" # Keywords, Storage, Selector, Markup Italic, Diff Changed
    let base0f = "{color15}" # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

# we're creating a theme here that uses the colors we defined above.

    let base16_theme = {
separator: $base03
             leading_trailing_space_bg: $base04
             header: $base0b
             date: $base0e
             filesize: $base0d
             row_index: $base0c
             bool: $base08
             int: $base0b
             duration: $base08
             range: $base08
             float: $base08
             string: $base04
             nothing: $base08
             binary: $base08
             cellpath: $base08
             hints: dark_gray
             shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
shape_bool: $base0d
              shape_int: { fg: "{foreground}" attr: b}
shape_float: { fg: "{foreground}" attr: b}
shape_range: { fg: "{foreground}" attr: b}
shape_internalcall: { fg: "{foreground}" attr: b}
shape_external: $base0c
                  shape_externalarg: { fg: "{foreground}" attr: b}
shape_literal: $base0d
                 shape_operator: $base0a
                 shape_signature: { fg: "{foreground}" attr: b}
shape_string: $base0b
                shape_filepath: $base0d
                shape_globpattern: { fg: "{foreground}" attr: b}
shape_variable: $base0e
                  shape_flag: { fg: "{foreground}" attr: b}
shape_custom: {attr: b}

}



            
$env.config = {
  menus: [
    {
      name: completion_menu
      only_buffer_difference: false # Search is done on the text written after activating the menu
      marker: "| "                  # Indicator that appears with the menu is active
      type: {
          layout: columnar          # Type of menu
          columns: 4                # Number of columns where the options are displayed
          col_width: 20             # Optional value. If missing all the screen width is used to calculate column width
          col_padding: 2            # Padding between columns
      }
      style: {
          text: green                   # Text style
          selected_text: green_reverse  # Text style for selected option
          description_text: yellow      # Text style for description
      }
    }
  ]
}
