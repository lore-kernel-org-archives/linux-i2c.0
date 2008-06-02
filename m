From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on
	Freescale	CPM1/CPM2 controllers
Date: Mon, 2 Jun 2008 20:26:30 +0100
Message-ID: <20080602192630.GD6226@fluff.org.uk>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
	<20080519155443.GA4279@pengutronix.de>
	<20080519184907.651a4e48@hyperion.delvare>
	<20080601222428.GC6226@fluff.org.uk>
	<20080602090850.1b8db039@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080602090850.1b8db039-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 02, 2008 at 09:08:50AM +0200, Jean Delvare wrote:
> Hi Ben,
> 
> On Sun, 1 Jun 2008 23:24:28 +0100, Ben Dooks wrote:
> > On Mon, May 19, 2008 at 06:49:07PM +0200, Jean Delvare wrote:
> > > Oh, BTW, nacks should be reported with -ENXIO according to:
> > > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-document-standard-fault-codes.patch
> > > It might be worth checking that this new driver complies with these
> > > freshly adopted error codes standard.
> > 
> > Hmm, where ECONREFUSED or EPIPE (if NAK in already selected device)
> > entertained?

[snip]

> As for the error code, it doesn't matter that much I think, as long as
> it is consistent. We've settled for ENXIO and I wouldn't change this
> now without a very good reason.

Sorry, I meant what happens if a NAK is received after the address
part of the i2c_msg has been sent, when sending the msg data? Is this
a case for an error like EPIPE, ENOLINK or EREMOTEIO?

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
