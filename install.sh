
cd /home/$USER/.local/share && git clone https://github.com/scott-astatine/OhVim.git

if ["/home/$USER/.config/nvim"] then
  mv /home/$USER/.config/nvim /home/$USER/.config/nvim.bak
fi

ln -s /home/$USER/.local/share/OhVim /home/$USER/.config/nvim
