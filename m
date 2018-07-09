From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [v2,3/3] i2c: at91: added slave mode support
Date: Mon, 9 Jul 2018 17:15:04 +0200
Message-ID: <20180709151504.6phtp4rm7of6b2qc@M43218.corp.atmel.com>
References: <c9b749fca8e684aa47ead9a5d9e68751326f63cb.1510247114.git.me@jue.yt>
 <20180602213513.qv45gaq2kogagju3@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180602213513.qv45gaq2kogagju3@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Juergen Fitschen <me@jue.yt>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Sorry for the delay to answer. I changed my email filters. Unfortunately
there was a bug and I missed message from this mailing list...

On Sat, Jun 02, 2018 at 11:35:13PM +0200, Wolfram Sang wrote:
> On Thu, Nov 09, 2017 at 06:22:29PM +0100, Juergen Fitschen wrote:
> > Slave mode driver is based on the concept of i2c-designware driver.
> > 
> > Signed-off-by: Juergen Fitschen <me@jue.yt>
> 
> I lost the original mail where Ludovic said:
> 
> "I tested it quickly on a sama5d2 xplained board: I used an i2c-gpio
> master and the eeprom driver. It works pretty well. I tried to increase
> the size of the eeprom by adding:
> + { "slave-24c64", 65536 / 8 },"
> 
> That won't work. The comment at the beginning of the file says:
> 
>  * ... It is prepared to simulate bigger EEPROMs with an internal 16 bit
>  * pointer, yet implementation is deferred until the need actually arises.
> 
> So,  no EEPROMs > 256 byte for now.

Sorry for having not catched it. If I remember well, it was the only
issue I had while testing the slave support.

> 
> BTW maybe I asked already and forgot: is this IP core capable of being
> master and slave on the same bus?
> 

No the master and slave modes are exclusive.

Regards

Ludovic
