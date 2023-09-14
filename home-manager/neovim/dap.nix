{
  plugins.dap = {
    enable = true;
    extensions = {
      dap-ui = {
        enable = true;
      };
      dap-virtual-text.enable = true;
      dap-python.enable = true;
      dap-go.enable = true;
    };
  };

  maps = {
    normal = {
      "<leader>d" = {
        desc = "  Dap";
      };
      "<leader>dc" = {
        desc = "Continue";
        action = "<cmd>lua function() require('dap').continue()<CR>";
        silent = true;
      };
      "<leader>db" = {
        desc = "Toggle Breakpoint";
        action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
        silent = true;
      };
      "<leader>di" = {
        desc = "Step Into";
        action = "<cmd>lua require('dap').step_into()<CR>";
        silent = true;
      };
      "<leader>do" = {
        desc = "Step Out";
        action = "<cmd>lua require('dap').step_out()<CR>";
        silent = true;
      };
      "<leader>dv" = {
        desc = "Step Over";
        action = "<cmd>lua function() require('dap').step_over()<CR>";
        silent = true;
    };
      "<leader>dr" = {
        desc = "Repl";
        action = "<cmd>lua function() require('dap').repl.open()<CR>";
        silent = true;
      };
      "<leader>dl" = {
        desc = "Run Last";
        action = "<cmd>lua function() require('dap').run_last()<CR>";
        silent = true;
      };
    };
  };
}
