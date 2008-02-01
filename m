From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [PATCH 3/3] Add support for PCA953[4-8] I2C GPIO extenders to
 the pca953x driver
Date: Fri, 1 Feb 2008 11:57:01 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802011156080.6065@axis700.grange>
References: <Pine.LNX.4.64.0801311453470.8478@axis700.grange>
	<200801311320.57437.david-b@pacbell.net>
	<Pine.LNX.4.64.0801312308110.3704@axis700.grange>
	<200801311535.41442.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200801311535.41442.david-b@pacbell.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: David Brownell <david-b@pacbell.net>
Cc: Jean Delvare <khali@linux-fr.org>, video4linux-list@redhat.com, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 31 Jan 2008, David Brownell wrote:

> Compare to this cleaned up version of your patch 3/3 ... which is a bit
> smaller since it removes reg_shift.  (Tell me I didn't break anything!)

You didn't:-) It still works.

Thanks
Guennadi
---
Guennadi Liakhovetski

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
