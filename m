From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 5/5] i2c-piix4: Add adapter port name support for
 SB800 chipset
Date: Mon, 02 Nov 2015 14:12:43 +0200
Message-ID: <1446466363.6332.94.camel@linux.intel.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
	 <1446395529-9987-6-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16928 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbbKBMMo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 07:12:44 -0500
In-Reply-To: <1446395529-9987-6-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com

On Sun, 2015-11-01 at 17:32 +0100, Christian Fetzer wrote:
> This patch adds support for port names for the SB800 chipset.
> Since the chipset supports a multiplexed main SMBus controller,
> adding
> the channel name to the adapter name is necessary to differentiate
> the
> ports better (for example in sensors output).


> +static const char *piix4_main_port_names_sb800[4] = {

Would it be constant you defined instead of magic number?

> +	"SDA0", "SDA2", "SDA3", "SDA4"


> +};
> +static const char *piix4_aux_port_name_sb800 = "SDA1";


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
