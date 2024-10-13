{pkgs, ...}: {
  getPassword = accountName:
  # https://github.com/teto/home/blob/315ec23bc5ee54cde0db4b2b2098e86f2728218c/hm/lib.nix#L24C1-L38C7
  # let
  #   # https://superuser.com/questions/624343/keep-gnupg-credentials-cached-for-entire-user-session
  #   # >  export PASSWORD_STORE_GPG_OPTS=" --default-cache-ttl 34560000"
  #   script = pkgs.writeShellScriptBin "pass-show" ''
  #     ${pkgs.pass}/bin/pass show "$@" | ${pkgs.coreutils}/bin/head -n 1
  #   '';
  # in
  # ["${script}/bin/pass-show" accountName];
  [
    "${pkgs.pass}/bin/pass"
    "show"
    accountName
  ];
}
