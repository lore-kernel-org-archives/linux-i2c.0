From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3] i2c: xlp9xx: add ACPI support for Broadcom Vulcan
Date: Mon, 20 Jun 2016 13:27:38 +0300
Message-ID: <20160620102738.GE1739@lahna.fi.intel.com>
References: <20160618140420.GA1430@tetsubishi>
 <1466414778-22879-1-git-send-email-tanmay.jagdale@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42411 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752AbcFTKar (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 20 Jun 2016 06:30:47 -0400
Content-Disposition: inline
In-Reply-To: <1466414778-22879-1-git-send-email-tanmay.jagdale@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com

On Mon, Jun 20, 2016 at 02:56:18PM +0530, Tanmay Jagdale wrote:
> Added ACPI support for the I2C controller present on Broadcom's
> Vulcan ARM64 processor. ACPI ID used by the controller is BRCM9007.
> 
> Changed the xlp9xx_i2c_get_frequency() function to use
> device_property_read_u32() API so that the "clock-frequency" value
> can be read from _DSD in ACPI mode.
> 
> Signed-off-by: Tanmay Jagdale <tanmay.jagdale@broadcom.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
