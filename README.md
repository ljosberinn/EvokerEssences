Evoker essences as bars.

Features:

- anchors to primary cooldown manager row
- automatically adjusts dimensions
- pixel perfect
- all 3 specs supported
- Essence Burst detection for all 3 specs (glows when active)
- Imminent Destruction detection
- dynamic colors/opacity based on
  - whether you cast anything at all (opacity is 0.5 if you cannot)
  - evoker class color when you can cast a spender
  - orange when you're recharging your final essence
  - red when you're capped on essences
- currently has two styles; @Krealle (default) and @ljosberinn, which is only active if your character name matches mine. to override it, edit `Init.lua` and add `isXeph = true` below the name check
