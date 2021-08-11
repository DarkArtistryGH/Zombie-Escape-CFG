—————————————————————————————————————————

 Hi, here is the configs for the bosshp

—————————————————————————————————————————


"math_counter"
{
    "config" //Опционально
    {
        "MultBoss"                    "" //Показывать несколько босс хп одновременно. 1/0, по стандарту 0
        "BossBeatenShowTopDamage"        "" //Показывать топ дамагеров и выдавать им кредиты. 1/0, по стандарту 1
    }
    "0"
    {
        //пример с math_counter
        "HP_counter"            "" //targetname основное хп у math_counter
        "HPbar_counter"            "" //targetname полоска хп у math_counter, если достигнуто минимальное или максимальное значение, то босс умрет (если есть)
        "HPinit_counter"        "" //targetname дополнительное хп у math_counter, которое будет возвращать основному math_counter хп при достижении минимального или максимального значения (если есть)
        "CustomText"            "" //Имя босса
        "HPbar_min"            "" //Минимальное значение полоски хп у math_counter (если есть)
        "HPbar_max"            "" //Максимальное значение полоски хп у math_counter (если есть)
        "HPbar_default"            "" //Стандартное значение полоски хп у math_counter (если есть)
        "HPbar_mode"            "" //Какой тип полоски хп у math_counter, 1=OnHitMin (мин. значение) 2=OnHitMax (макс. значение) (если есть)
        "Money"                    "" //Сколько денег выдавать за попадание по боссу (если указать 0, то выдавать не будет), если не писать, то будет выдаваться по стандарту.
        "Credits"               "" //Сколько кредитов выдавать за босса (если указать 0 ,то выдавать не будет), если не писать, то будет выдаваться по стандарту.
    }
    "1"
    {
        //примеры с func_breakable, func_physbox или func_physbox_multiplayer
        "Type"                "breakable"    //Смена типа на func_breakable, func_physbox и func_physbox_multiplayer
        "BreakableName"            ""         //targetname у func_breakable, func_physbox или func_physbox_multiplayer
        "CustomText"            ""        //Какое имя босса показывать игрокам
    }
}
© 2021 GitHub, Inc.
