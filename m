From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] rtc-ds1307: True SMBus compatibility
Date: Tue, 6 Jan 2009 14:48:55 -0800
Message-ID: <200901061448.56500.david-b@pacbell.net>
References: <1231177261.13443.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756968AbZAFWt0@vger.kernel.org>
In-Reply-To: <1231177261.13443.20.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ed Swierk <eswierk@aristanetworks.com>
Cc: linux-i2c@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, BARRE Sebastien <sbarre@sdelcc.com>
List-Id: linux-i2c@vger.kernel.org

On Monday 05 January 2009, Ed Swierk wrote:
> Reading or writing registers repeatedly until they stick is rather
> nauseating but I'm aiming for correctness if not elegance.  I would
> appreciate any suggestions for improvement.

Can i2c_smbus_read_i2c_block_data()/i2c_ smbus_write_i2c_block_data()
work better -- without nauseating anyone?

Faking atomic writes doesn't seem "correct" to me.  Minimally there
is the case of an alarm misfiring.

- Dave
