#!/usr/bin/bash
sudo -v
cd ~/Documents/homelab
git pull
sudo nixos-rebuild switch --flake .#salas
