From: Curt Brune <curt@cumulusnetworks.com>
Subject: Re: [RFC] Creating an eeprom class
Date: Wed, 22 Jan 2014 09:18:12 -0800
Message-ID: <20140122171812.GA29955@cumulusnetworks.com>
References: <CAOMwXhMvefuQJPZ_sbzySmvcyqkR+Lfh-11Gx3unGqyR2pREww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMwXhMvefuQJPZ_sbzySmvcyqkR+Lfh-11Gx3unGqyR2pREww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laszlo Papp <lpapp@kde.org>
Cc: LKML <linux-kernel@vger.kernel.org>, patrickdepinguin@gmail.com, gregkh@linuxfoundation.org, linux-i2c@vget.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Laszlo,

On Wed Jan 22 13:25, Laszlo Papp wrote:
> 
> Was there any progress done? I saw the following thread, too, so
> including CC in the loop:
> http://www.spinics.net/lists/linux-i2c/msg13141.html
> 

I have patches that adds a "eeprom_dev" class that I described in the
above thread.  The patches also show how to register the at24 driver
with the EEPROM class.

We have been using the patch in production for almost a year now, with
good success.

I will send the patches to linux-i2c@vget.kernel.org shortly.

Cheers,
Curt
