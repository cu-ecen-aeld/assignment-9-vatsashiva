##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

AESD_ASSIGNMENTS_VERSION = assignments-9
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-vatsashiva.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

AESD_ASSIGNMENTS_DEPENDENCIES = linux

# Build and install aesdchar.ko using Buildroot kernel module infrastructure
AESD_ASSIGNMENTS_MODULE_SUBDIRS = aesd-char-driver

define AESD_ASSIGNMENTS_BUILD_CMDS
	@echo "***** BUILDING AESD SOCKET SERVER *****"
    	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server clean
    	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
    	$(INSTALL) -d $(TARGET_DIR)/usr/bin
    	$(INSTALL) -d $(TARGET_DIR)/etc/init.d

	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket
    	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
    	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/etc/init.d/S98aesdchar
endef
	

$(eval $(kernel-module))
$(eval $(generic-package))
