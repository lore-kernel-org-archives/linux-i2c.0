From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] modpost: i2c aliases need no trailing wildcard
Date: Sat, 3 May 2008 20:04:20 +0200
Message-ID: <20080503180420.GA17990@uranus.ravnborg.org>
References: <20080502203721.70c5dc09@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933031AbYECSDz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080502203721.70c5dc09@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Kay Sievers <kay.sievers@vrfy.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 02, 2008 at 08:37:21PM +0200, Jean Delvare wrote:
> Hi all,
> 
> [Once more with Sam's address fixed, sorry for the noise.]
> 
> Not all device types need a wildcard at the end of their module
> aliases. In particular, for i2c module aliases, the trailing wildcard
> is not only unneeded, it could also cause the wrong driver to be
> loaded.
...
Hi Jean.

Do you expect me to take this via kbuild.git?

	Sam
