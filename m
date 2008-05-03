From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] modpost: i2c aliases need no trailing wildcard
Date: Sat, 3 May 2008 21:12:57 +0200
Message-ID: <20080503211257.389a0607@hyperion.delvare>
References: <20080502203721.70c5dc09@hyperion.delvare>
	<20080503180420.GA17990@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753235AbYECTNT@vger.kernel.org>
In-Reply-To: <20080503180420.GA17990@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Kay Sievers <kay.sievers@vrfy.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sam,

On Sat, 3 May 2008 20:04:20 +0200, Sam Ravnborg wrote:
> On Fri, May 02, 2008 at 08:37:21PM +0200, Jean Delvare wrote:
> > Hi all,
> > 
> > [Once more with Sam's address fixed, sorry for the noise.]
> > 
> > Not all device types need a wildcard at the end of their module
> > aliases. In particular, for i2c module aliases, the trailing wildcard
> > is not only unneeded, it could also cause the wrong driver to be
> > loaded.
> ...
> Hi Jean.
> 
> Do you expect me to take this via kbuild.git?

At your option. If it's easier for you to synchronize with other
patches possibly touching this file, please do. If not, I can push it
via my i2c tree. Just let me know.

-- 
Jean Delvare
