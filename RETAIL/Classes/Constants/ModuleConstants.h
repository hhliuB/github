
/******************************************************************************
 *  @file   : ModuleConstants.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-10
 *  @brief  : 定义应用程序菜单中可选的功能项个数
 *            以及每项的类型、内容、对应的视图控制器等
 ******************************************************************************/


#ifndef SFAExample_ModuleConstants_h
#define SFAExample_ModuleConstants_h

/**
 *  进入 App 时默认选中的 index
 */
#define kDefaultModuleIndex    0

/**
 *  是否显示 Settings 按钮。0，不显示；1，显示
 */
#define kSettingsModuleEnabled 0

/**
 *  按钮类型枚举。以下内容不允许修改
 */
#define ModuleStyleDay         0
#define ModuleStyleMonth       1
#define ModuleStyleText        2
#define ModuleStyleImage       3
#define ModuleStyleImageText   4
#define ModuleStyleSettings    9999
// ---------------------- 以上内容不允许修改

typedef struct Module {
  int   style;
  char *title;
  char *normalImageName;
  char *selectedImageName;
  char *viewControllerName;
} Module;

/**
 *  菜单内容及样式
 */
static Module g_modules[] = {
  { ModuleStyleDay,   NULL, NULL,                  NULL,                  "HomePageViewController"    },
  { ModuleStyleImageText, "频道", "menu_planning_a.png", "menu_planning_b.png", "ChannelViewController" },
  { ModuleStyleImageText, "分类", "menu_schedule_a.png", "menu_schedule_b.png", "ClassificationViewController" },
  { ModuleStyleImageText, "搜索", "menu_terminal_a.png", "menu_terminal_b.png", "SearchViewController" },
  { ModuleStyleImageText, "个人中心", "menu_product_a.png",  "menu_product_b.png",  "IndividualCenterViewController"  },
};

/**
 *  Settings 按钮样式
 */
static Module g_settingsModule = {
  ModuleStyleSettings,
  NULL,
  "menu_settings_a.png",
  "menu_settings_b.png",
  NULL
};

#endif
