From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 1/5] i2c-piix4: Optionally release smba in
 piix4_adap_remove
Date: Mon, 2 Nov 2015 12:46:52 +0200
Message-ID: <20151102104652.GE1509@lahna.fi.intel.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
 <1446395529-9987-2-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51453 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbbKBKq4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 05:46:56 -0500
Content-Disposition: inline
In-Reply-To: <1446395529-9987-2-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>
Cc: linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com

On Sun, Nov 01, 2015 at 05:32:05PM +0100, Christian Fetzer wrote:
> -static void piix4_adap_remove(struct i2c_adapter *adap)
> +static void piix4_adap_remove(struct i2c_adapter *adap, int free_smba)

How about bool instead?
