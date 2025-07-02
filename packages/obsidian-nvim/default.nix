{
  vimUtils,
  pkgs,
  inputs,
}:
vimUtils.buildVimPlugin {
  pname = "obsidian.nvim";
  src = inputs.obsidian-nvim;
  version = inputs.obsidian-nvim.shortRev;
  meta.homepage = "https://github.com/obsidian-nvim/obsidian.nvim/";
  meta.hydraPlatforms = [ ];
  dependencies = [ pkgs.vimPlugins.trouble-nvim ];
  nvimSkipModule = [
    "obsidian.builtin"
    "obsidian.health"
    "obsidian.statusline.init"
    "obsidian.completion.sources.blink.refs"
    "obsidian.completion.sources.nvim_cmp.refs"
    "obsidian.completion.sources.base.refs"
    "obsidian.config"
    "obsidian.workspace"
    "obsidian.pickers.init"
    "obsidian.commands.toggle_checkbox"
    "obsidian.commands.link"
    "obsidian.commands.workspace"
    "obsidian.commands.tags"
    "obsidian.commands.toc"
    "obsidian.commands.new"
    "obsidian.commands.link_new"
    "obsidian.commands.new_from_template"
    "obsidian.commands.extract_note"
    "obsidian.api"
    "obsidian.completion.sources.nvim_cmp.new"
    "obsidian.completion.sources.base.tags"
    "obsidian.completion.sources.base.new"
    "obsidian.daily.init"
    "obsidian.search"
    "obsidian.pickers._telescope"
    "obsidian.pickers.picker"
    "obsidian.pickers._snacks"
    "obsidian.pickers._mini"
    "obsidian.pickers._fzf"
    "obsidian.commands.check"
    "obsidian.commands.rename"
    "obsidian.commands.paste_img"
    "obsidian.commands.backlinks"
    "obsidian.commands.open"
    "obsidian.commands.links"
    "obsidian.commands.template"
    "obsidian.commands.dailies"
    "obsidian.img_paste"
    "obsidian.ui"
    "obsidian.client"
    "obsidian.note"
    "obsidian.templates"
    "obsidian.async"
    "obsidian.completion.init"
    "obsidian.completion.tags"
    "obsidian.completion.sources.blink.tags"
    "obsidian.completion.sources.blink.new"
    "obsidian.completion.sources.nvim_cmp.tags"
    "minimal"
  ];
}
