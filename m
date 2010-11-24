From: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Subject: i2c-ocores changes
Date: Wed, 24 Nov 2010 15:09:47 +0100
Message-ID: <1290607789-8996-1-git-send-email-jonas@southpole.se>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Here are a couple of patches that fix up the initialization path of
the i2c-cores driver:

i)  Support for device tree configuration of i2c devices
ii) Use devres routines in the resource reservation paths for device
initialization

This has been tested on an OpenRISC 1200 board; the OpenRISC Linux port
depends on device trees for device enumeration.

/Jonas
