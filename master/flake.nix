{
  description = ''Wrapper for vk.com API'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-vkapi-master.flake = false;
  inputs.src-vkapi-master.owner = "Yardanico";
  inputs.src-vkapi-master.ref   = "master";
  inputs.src-vkapi-master.repo  = "nimvkapi";
  inputs.src-vkapi-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-vkapi-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-vkapi-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}