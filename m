From: Jean Delvare <jdelvare@suse.de>
Subject: Re: SMBus not found
Date: Fri, 03 Feb 2017 11:53:28 +0100
Message-ID: <1486119208.4299.11.camel@suse.de>
References: <CANE=DpU===GBGNY0+QJCKuw295kkYSEPN-oeaT7cG6DRcNdjiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752296AbdBCKxf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 3 Feb 2017 05:53:35 -0500
In-Reply-To: <CANE=DpU===GBGNY0+QJCKuw295kkYSEPN-oeaT7cG6DRcNdjiA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hrvoje T <hrvooje@jankovci.net>, linux-i2c@vger.kernel.org

Hi Hrvoje,

Please use plain text (no HTML) when writing to development lists.

On jeu., 2017-02-02 at 14:50 +0100, Hrvoje T wrote:
> When I run sensors-detect I get an answer:
> Do you want to probe the I2C/SMBus adapters now? (YES/no): yes
> Sorry, no supported PCI bus adapters found.
> Is tehere anything else I can try?

You did not tell which version of sensors-detect you tried, nor what
kernel you are running, nor what your hardware is. What kind of help
are you expecting?

You should probably not be using sensors-detect in the first place
anyway. i2cdetect (from the i2c-tools package) is a much better tool
for what you are trying to do.

> Is it possible to dump addresses 0x50-0x57 on this bus with i2cdump
> and run decode-dimms -x on them? How could I do this when I don't
> know which bus is SMBus?

This question makes no sense as "this bus" is clearly undefined at this
point. First check what I2C/SMBus busses are available on your system:

# modprobe i2c-dev
# i2cdetect -l

Then either run i2cdetect / i2cdump on the relevant bus if it was
listed, or try to figure out why it is not listed (looking for it with
lspci maybe, if your SMBus controller is a PCI device.)

-- 
Jean Delvare
SUSE L3 Support
