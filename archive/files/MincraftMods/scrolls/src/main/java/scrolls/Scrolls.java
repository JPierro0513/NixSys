package scrolls;

import net.fabricmc.api.ModInitializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import scrolls.items.ModItems;

public class Scrolls implements ModInitializer {

    public static final String MOD_ID = "scrolls";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        LOGGER.info("Hello Fabric world!");

        LOGGER.info("Initializing items...");
        ModItems.initialize();
        LOGGER.info("Items initialized!");
    }
}
