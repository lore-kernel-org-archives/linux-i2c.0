From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hwmon: Included max1618 support in max1619 driver
Date: Mon, 11 Aug 2008 17:27:21 -0700
Message-ID: <20080811172721.5ef6c1f6.akpm@linux-foundation.org>
References: <200808111141.12891.tobias@himmer-online.de>
	<20080811122102.034f6f2f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755801AbYHLA2W@vger.kernel.org>
In-Reply-To: <20080811122102.034f6f2f@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: tobias@himmer-online.de, i2c@lm-sensors.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, hjk@linutronix.de, fishor@mail.ru
List-Id: linux-i2c@vger.kernel.org

On Mon, 11 Aug 2008 12:21:02 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> On Mon, 11 Aug 2008 11:41:12 +0200, Tobias Himmer wrote:
> > Hi,
> > 
> > I modified the existing max1619 driver in order to support the MAX1618 chip,
> > a stripped down version of the MAX1619.
> 
> Wrong mailing list. Please send to the lm-sensors list.
> 

Please also prepare and test the patch against current Linus mainline. 
Or even linux-next, although that isn't necessary in this particular case.

Your patch appeared to be against 2.6.26, and that was a long time ago
in kernel terms.  It is not applicable to current development kernels.
