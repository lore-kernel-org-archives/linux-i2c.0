From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on Freescale
 CPM1/CPM2 controllers
Date: Mon, 2 Jun 2008 09:08:50 +0200
Message-ID: <20080602090850.1b8db039@hyperion.delvare>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
	<20080519155443.GA4279@pengutronix.de>
	<20080519184907.651a4e48@hyperion.delvare>
	<20080601222428.GC6226@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080601222428.GC6226-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Sun, 1 Jun 2008 23:24:28 +0100, Ben Dooks wrote:
> On Mon, May 19, 2008 at 06:49:07PM +0200, Jean Delvare wrote:
> > Oh, BTW, nacks should be reported with -ENXIO according to:
> > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-document-standard-fault-codes.patch
> > It might be worth checking that this new driver complies with these
> > freshly adopted error codes standard.
> 
> Hmm, where ECONREFUSED or EPIPE (if NAK in already selected device)
> entertained?

There's no such thing as an "already selected device". The bus driver
doesn't know whether a given transaction is meant for probing purposes
(in which case a failure is more or less expected) or if it is a real
transaction. So it must either always log (which can spam the log) or
never log (which can cause some errors to go unnoticed.) Once a bus
driver returns proper error codes, I think that the best approach is to
not log anything (or only at debug level) on NAK and to let the chip
driver deal with the error.

As for the error code, it doesn't matter that much I think, as long as
it is consistent. We've settled for ENXIO and I wouldn't change this
now without a very good reason.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
