From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 12/24] media/video: fix dangling pointers
Date: Mon, 22 Mar 2010 21:51:18 +0000
Message-ID: <20100322215118.GC17533@sirena.org.uk>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
 <20100321144655.4747fd2a@hyperion.delvare>
 <20100321141417.GA19626@opensource.wolfsonmicro.com>
 <201003211709.56319.hverkuil@xs4all.nl>
 <20100322213358.31e50b3c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100322213358.31e50b3c@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Wolfram Sang <w.sang@pengutronix.de>, kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 22, 2010 at 09:33:58PM +0100, Jean Delvare wrote:
> On Sun, 21 Mar 2010 17:09:56 +0100, Hans Verkuil wrote:
> > On Sunday 21 March 2010 15:14:17 Mark Brown wrote:

> > > I agree with this.  There are also some use cases where the device data
> > > is actually static (eg, a generic description of the device or a
> > > reference to some other shared resource rather than per device allocated
> > > data).

> From a technical perspective, there is little rationale to have the
> client data pointed to static data. If you could reach it from probe(),
> it has to be a global, and if it is a global, you can reach it again
> directly from the rest of your code.

The use case I can think of there is bus type specific stuff for devices
that support multiple buses.
