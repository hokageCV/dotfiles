#r "C:\Program Files\workspacer\workspacer.Shared.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"

using System;
using workspacer;
using workspacer.Bar;
using workspacer.Bar.Widgets;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;

Action<IConfigContext> doConfig = (context) =>
{
    context.AddBar(new BarPluginConfig()
    {
        FontSize = 9,
        BarHeight = 19,
        FontName = "JetBrains Mono",
        // doesn't accept transpency in 4th argument of color. tried it
        DefaultWidgetBackground = new Color(47, 52, 56),
        LeftWidgets = () => new IBarWidget[]
        {
            new WorkspaceWidget()
        },
        RightWidgets = () => new IBarWidget[]{}
    });

    context.AddFocusIndicator();
    var actionMenu = context.AddActionMenu();

    context.DefaultLayouts = () => new ILayoutEngine[] {
        new TallLayoutEngine(),  // Default tiling
        // new VertLayoutEngine(),   // stacked top to bottom
        new HorzLayoutEngine(), // stacked left to right
        new FullLayoutEngine()   // Maximized
    };

    context.WorkspaceContainer.CreateWorkspaces("1", "2", "3", "4", "5", "6", "7", "8");
    context.CanMinimizeWindows = true;
};
return doConfig;
