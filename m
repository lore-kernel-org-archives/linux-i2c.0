From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 01/26] docs: i2c: sort index logically
Date: Sun,  5 Jan 2020 23:49:47 +0100
Message-ID: <20200105225012.11701-1-luca@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105224006.10321-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The index page currently lists sections in alphabetical file order without
caring about their content. Sort sections based on their content logically,
according to the following structure:

 * Intro to I2C/SMBus and their usage in Linux: summary, i2c-protocol,
   smbus-protocol, instantiating-devices, busses/index, i2c-topology,
   muxes/i2c-mux-gpio
 * Implementing drivers: writing-clients, dev-interface,
   dma-considerations, fault-codes, functionality
 * Debugging: gpio-fault-injection, i2c-stub
 * Slave I2C: slave-interface, slave-eeprom-backend
 * Advanced: ten-bit-addresses
 * Obsolete info: upgrading-clients, old-module-parameters

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/i2c/index.rst | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/i2c/index.rst b/Documentation/i2c/index.rst
index a0fbaf6d0675..bd0ff9d00793 100644
--- a/Documentation/i2c/index.rst
+++ b/Documentation/i2c/index.rst
@@ -7,27 +7,26 @@ I2C/SMBus Subsystem
 .. toctree::
    :maxdepth: 1
 
+   summary
+   i2c-protocol
+   smbus-protocol
+   instantiating-devices
+   busses/index
+   i2c-topology
+   muxes/i2c-mux-gpio
+   writing-clients
    dev-interface
    dma-considerations
    fault-codes
    functionality
    gpio-fault-injection
-   i2c-protocol
    i2c-stub
-   i2c-topology
-   instantiating-devices
-   old-module-parameters
-   slave-eeprom-backend
    slave-interface
-   smbus-protocol
-   summary
+   slave-eeprom-backend
    ten-bit-addresses
    upgrading-clients
-   writing-clients
-
-   muxes/i2c-mux-gpio
+   old-module-parameters
 
-   busses/index
 
 .. only::  subproject and html
 
-- 
2.24.1
