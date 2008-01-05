From: "Chandra shekhar" <x0044955-l0cyMroinI0@public.gmane.org>
Subject: Re: I2C host adapter slave support
Date: Sat, 5 Jan 2008 22:43:12 +0530
Message-ID: <200801051713.m05HDElg011590@dbdp31.itg.ti.com>
References: <477EBD8D.9000807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <477EBD8D.9000807-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: 'Nishanth Menon' <menon.nishanth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

 
> Chandra shekhar wrote:
> > I am implementing i2c slave mode transfers, and found out 
> that there isn't really any support in the subsystem for this.
> > Also I did not find any discussions regarding this in i2c 
> mailing list. 
> > Are there any discussions or plans about implementing host 
> adapter slave support in i2c subsytem?
> >   
> one thread of interest is:
> http://lists.lm-sensors.org/pipermail/i2c/2007-April/001027.html

This is more related to opearting speed for i2c devices sitting on a common bus.


> Quote">/ > Russell King has added I2C slave support at least 
> for PXA... 
> /I'm curious. How does it work? Does this means that there is 
> no need for cooperation from i2c-core to implement I2C slave 
> support in I2C bus drivers? Or is i2c-pxa implementing things 
> which should be moved to i2c-core? 

Precisely,  this is my question. If we were to support slave mode there should be
Some callback or hooks to trigger upper layer app. after receive operations, which 
Ideally should be part of i2c-core I think. 
I am yet to look at i2c-pxa code.


This discussion probably 
> belongs to a different thread though, I doesn't seem to be 
> related to bus speed issues at all. "
> 
> Finally see the slave implementation here:
> http://www.gelato.unsw.edu.au/lxr/source/drivers/i2c/busses/i2c-pxa.c
> Regards,
> Nishanth Menon
> 
