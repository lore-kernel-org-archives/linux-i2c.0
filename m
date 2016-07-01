From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] i2c: 'i2c-bus' node support for v4.8-rc1
Date: Fri,  1 Jul 2016 17:00:55 +0200
Message-ID: <20160701150056.26537-2-thierry.reding@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33449 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbcGAPBR (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Jul 2016 11:01:17 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org

Hi Wolfram,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-i2c

for you to fetch changes up to 7e4c224abfe8e2a00f56a2ef0198e6de3ca1852c:

  i2c: core: Add support for 'i2c-bus' subnode (2016-06-30 11:02:17 +0200)

Thanks,
Thierry

----------------------------------------------------------------
i2c: 'i2c-bus' node support for v4.8-rc1

This includes the device tree binding and I2C core changes to support
the i2c-bus subnode that I2C masters can use to describe their slaves
in a separate namespace and therefore avoid clashing with potentially
other subnodes.

----------------------------------------------------------------
Jon Hunter (2):
      dt-bindings: i2c: Add support for 'i2c-bus' subnode
      i2c: core: Add support for 'i2c-bus' subnode

 Documentation/devicetree/bindings/i2c/i2c.txt |  8 ++++++++
 drivers/i2c/i2c-core.c                        | 10 ++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)
