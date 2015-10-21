From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [RESEND PATCH 0/9] eeprom: at24: at24cs series serial number read
Date: Wed, 21 Oct 2015 13:03:36 +0200
Message-ID: <87bnbsiiuv.fsf@dell.be.48ers.dk>
References: <1445330607-12470-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33795 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbbJULDk (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 07:03:40 -0400
In-Reply-To: <1445330607-12470-1-git-send-email-bgolaszewski@baylibre.com>
	(Bartosz Golaszewski's message of "Tue, 20 Oct 2015 10:43:18 +0200")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

>>>>> "Bartosz" == Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

 > Chips from the at24cs EEPROM series have an additional read-only memory area
 > containing a factory pre-programmed serial number. In order to access it, a
 > dummy write must be executed before reading the serial number bytes.

 > This series adds support for reading the serial number through a sysfs
 > attribute.

 > While we're at it: some of the patches contain readability tweaks and code
 > organization fixes.

 > Tested with at24cs64 and at24cs02 chips (for both 16 and 8 bit address
 > pointers).

As the serial number is available on a separate i2c address, wouldn't
it be simpler to handle these as special (read only) device variants and
instantiate E.G. a 24c64 (for the normal data) and a 24cs64 (for the
serial)?

-- 
Bye, Peter Korsgaard
