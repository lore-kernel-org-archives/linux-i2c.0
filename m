From: Denis Turischev <denis@compulab.co.il>
Subject: [PATCH 0/3] Add Intel SCH GPIO driver
Date: Thu, 11 Feb 2010 12:24:46 +0200
Message-ID: <4B73DAEE.5080400@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, David Brownell <dbrownell@users.sourceforge.net>, Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

LPC bridge controller of Intel SCH contains several functions.
Currently, LPC bridge controller PCI device is claimed by SMBus driver
thus disabling ability to have an additional driver for the LPC bridge
PCI device. This patch series introduces and MFD driver that creates
platform_device for both SMBus and GPIO controller, converts  SMBus
driver to platform_driver and adds the driver for GPIO controller
