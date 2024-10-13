{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.misc.notmuch;
in {
  options.modules.misc.notmuch.enable = lib.mkEnableOption "notmuch";
  config = lib.mkIf cfg.enable {
    programs = {
      mbsync.enable = true;
      lieer.enable = true;
      msmtp.enable = true;

      notmuch = {
        enable = true;
        hooks = {
          preNew = "mbsync --all";
        };
      };
    };

    services.lieer.enable = true;

    accounts.email = {
      accounts.bwkam = {
        flavor = "gmail.com";
        address = pkgs.runCommand "script" {} "cat ${config.sops.secrets."mail/bwkam/email".path}";
        msmtp.enable = true;
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
          patterns = ["*" "![Gmail]*" "[Gmail]/Sent Mail" "[Gmail]/Starred" "[Gmail]/All Mail"];
          extraConfig = {
            channel = {
              Sync = "All";
            };
          };
        };

        folders = {
          drafts = "drafts";
          inbox = "inbox";
          sent = "sent";
          trash = "trash";
        };

        notmuch.enable = true;
        passwordCommand = ''cat ${config.sops.secrets."mail/bwkam/password".path}'';

        imap = {
          host = "imap.gmail.com";
          port = 993;
        };

        primary = true;
        realName = "Beshoy Kamel";
        userName = ''${config.sops.secrets."mail/bwkam/email".path}'';
        lieer.enable = true;
        lieer.sync.enable = true;
      };
    };
  };
}
