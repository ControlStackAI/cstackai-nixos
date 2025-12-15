# DEPRECATED: use ./repos.nix instead
{ homeDir, projectsDir ? "${homeDir}/GithubProjects" }:
import ./repos.nix { inherit homeDir projectsDir; }
