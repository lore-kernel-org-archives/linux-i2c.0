From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v6 08/19] i2c: octeon: Enable High-Level Controller
Date: Thu, 21 Apr 2016 15:40:53 +0200
Message-ID: <20160421134053.GB2623@hardcore>
References: <cover.1460387640.git.jglauber@cavium.com>
 <34aac0bb7c0ae1c0ef7ca43d087059d04d9d8b09.1460387640.git.jglauber@cavium.com>
 <20160420214354.GD1546@katana>
 <5717FAC3.6010406@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1bon0084.outbound.protection.outlook.com ([157.56.111.84]:64078
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751302AbcDUNlO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Apr 2016 09:41:14 -0400
Content-Disposition: inline
In-Reply-To: <5717FAC3.6010406@caviumnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On Wed, Apr 20, 2016 at 02:55:15PM -0700, David Daney wrote:
> On 04/20/2016 02:43 PM, Wolfram Sang wrote:
> >On Mon, Apr 11, 2016 at 05:28:39PM +0200, Jan Glauber wrote:
> [...]
> >>+ */
> >>+static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
> >>+{
> >>+	int time_left;
> >>+
> >>+	octeon_i2c_hlc_int_enable(i2c);
> >>+	time_left = wait_event_interruptible_timeout(i2c->queue,
> >>+					octeon_i2c_hlc_test_ready(i2c),
> >>+					i2c->adap.timeout);
> >
> >Have you tested signal handling thoroughly? Most driver dropped the
> >_interruptible after a while. Mostly they found out that the state
> >machine of the interrupt handler couldn't gracefully deal with it and
> >nobody really needed the interruptible. Just saying.
> 
> Good point.  We know that exiting with a signal leaves us in an
> undefined state.
> 
> We will have to think on this point.

I think we should just drop the _interruptible_ and use
wait_event_timeout. The same is already used in the octeon_i2c_wait().
The 2ms timeout should not hurt anyone.

> >
> >>+	octeon_i2c_int_disable(i2c);
> >>+	if (!time_left) {
> >>+		octeon_i2c_hlc_int_clear(i2c);
> >>+		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
> >>+		return -ETIMEDOUT;
> >>+	}
> >>+
> >>+	if (time_left < 0) {
> >>+		dev_dbg(i2c->dev, "%s: wait interrupted\n", __func__);
> >>+		return time_left;
> >>+	}
> >>+	return 0;
> >>+}
> >
> >Drop the debug messages?
> >
> >I can't say much about the HW details, of course. Didn't spot anything
> >suspicious there.
> >
