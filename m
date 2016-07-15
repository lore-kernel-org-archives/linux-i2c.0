From: Austin Christ <austinwc@codeaurora.org>
Subject: [PATCH v5 0/2] Add ACPI support and SMBus block read
Date: Fri, 15 Jul 2016 14:08:40 -0600
Message-ID: <1468613322-3219-1-git-send-email-austinwc@codeaurora.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50010 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbcGOUIt (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Jul 2016 16:08:49 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: nkaje@codeaurora.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, rruigrok@codeaurora.org, timur@codeaurora.org, cov@codeaurora.org, linux-arm-kernel@lists.infradead.org, Austin Christ <austinwc@codeaurora.org>

Add ACPI support to I2C QUP driver and get properties from ACPI table.

Add support to the I2C QUP driver to correctly handle SMBus block reads by
checking I2C_M_RECV_LEN flag and reading the first byte received as the
message length.

Documentation for the two properites used from ACPI will be submitted through
dsd@acpica.org to https://github.com/ahs3/dsd. The documentation submitted will
be the following:

property-set:   I2C Device Properties
set-type:       definition
vendor:         Qualcomm Technologies, Inc.
bus:            acpi
device-id:      QCOM8010
revision:       0
derived-from:   /Qualcomm/acpi/QCOM8010/0

property:       clock-frequency
type:           integer
description:
                Defines the target clock frequency of the I2C bus.
values:
                integer:            0..20000000
                description:        integer value in hertz

example:
                Package (2) { "clock-frequency", 100000 }

property:       src-clock-hz
type:           integer
description:
                If present, defines the source clock frequency input
                into the I2C QUP controller
values:
                integer:            100000..1000000000
                description:        integer value in hertz
example:
                Package (2) { "src-clock-hz", 20000000}

[V5]
 - remove warning and use correct ACPI function
[V4]
 - correct error code
 - remove warning for fall back to default clock frequency
[V3]
 - clean up unused variables
 - use constant instead of variable for smbus length field
[V2]
 - rework the smbus block read and break into separate function
 - clean up redundant checks and variables

Naveen Kaje (2):
  i2c: qup: add ACPI support
  i2c: qup: support SMBus block read

 drivers/i2c/busses/i2c-qup.c | 126 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 107 insertions(+), 19 deletions(-)

--
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
