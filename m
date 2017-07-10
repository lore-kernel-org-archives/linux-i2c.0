From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v2 0/6] drivers/i2c: Add FSI-attached I2C master algorithm
Date: Mon, 10 Jul 2017 13:37:56 -0500
Message-ID: <1499711882-12918-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44751 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753245AbdGJSiK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 10 Jul 2017 14:38:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6AIbNoP066356
        for <linux-i2c@vger.kernel.org>; Mon, 10 Jul 2017 14:38:10 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bmbr5qke0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-i2c@vger.kernel.org>; Mon, 10 Jul 2017 14:38:10 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-i2c@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Mon, 10 Jul 2017 12:38:09 -0600
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, gregkh@linuxfoundation.org, jk@ozlabs.org, joel@jms.id.au, andrew@aj.id.au, eajames@linux.vnet.ibm.com, cbostic@linux.vnet.ibm.com, "Edward A. James" <eajames@us.ibm.com>

From: "Edward A. James" <eajames@us.ibm.com>

This series adds an algorithm for an I2C master physically located on an FSI
slave device. The I2C master has multiple ports, each of which may be connected
to an I2C slave. Access to the I2C master registers is achieved over FSI bus.

Due to the multi-port nature of the I2C master, the driver instantiates a new
I2C adapter for each port connected to a slave. The connected ports should be
defined in the device tree under the I2C master device.

Changes since v1:
 * Switch "port" to "i2c-bus" for child nodes in the dt.
 * Switch "port" to "reg" dt property.
 * Add example device under i2c-bus node in docs.
 * Set of_node of I2C adapter.
 * Use dynamically allocated numbering for I2C adapters.
 * Remove ida counters; unnecessary.

Edward A. James (6):
  drivers/i2c: Add FSI-attached I2C master algorithm
  drivers/i2c: Add port structure to FSI algorithm
  drivers/i2c: Add transfer implementation for FSI algorithm
  drivers/i2c: Add I2C master locking to FSI algorithm
  drivers/i2c: Add bus recovery for FSI algorithm
  dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation

 Documentation/devicetree/bindings/i2c/i2c-fsi.txt |  40 ++
 drivers/i2c/busses/Kconfig                        |  11 +
 drivers/i2c/busses/Makefile                       |   1 +
 drivers/i2c/busses/i2c-fsi.c                      | 637 ++++++++++++++++++++++
 4 files changed, 689 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 drivers/i2c/busses/i2c-fsi.c

-- 
1.8.3.1
