From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v6 08/19] i2c: octeon: Enable High-Level Controller
Date: Wed, 20 Apr 2016 14:55:15 -0700
Message-ID: <5717FAC3.6010406@caviumnetworks.com>
References: <cover.1460387640.git.jglauber@cavium.com> <34aac0bb7c0ae1c0ef7ca43d087059d04d9d8b09.1460387640.git.jglauber@cavium.com> <20160420214354.GD1546@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0087.outbound.protection.outlook.com ([65.55.169.87]:40992
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751179AbcDTVzV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 20 Apr 2016 17:55:21 -0400
In-Reply-To: <20160420214354.GD1546@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jan Glauber <jglauber@cavium.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On 04/20/2016 02:43 PM, Wolfram Sang wrote:
> On Mon, Apr 11, 2016 at 05:28:39PM +0200, Jan Glauber wrote:
[...]
>> + */
>> +static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
>> +{
>> +	int time_left;
>> +
>> +	octeon_i2c_hlc_int_enable(i2c);
>> +	time_left = wait_event_interruptible_timeout(i2c->queue,
>> +					octeon_i2c_hlc_test_ready(i2c),
>> +					i2c->adap.timeout);
>
> Have you tested signal handling thoroughly? Most driver dropped the
> _interruptible after a while. Mostly they found out that the state
> machine of the interrupt handler couldn't gracefully deal with it and
> nobody really needed the interruptible. Just saying.

Good point.  We know that exiting with a signal leaves us in an 
undefined state.

We will have to think on this point.


>
>> +	octeon_i2c_int_disable(i2c);
>> +	if (!time_left) {
>> +		octeon_i2c_hlc_int_clear(i2c);
>> +		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	if (time_left < 0) {
>> +		dev_dbg(i2c->dev, "%s: wait interrupted\n", __func__);
>> +		return time_left;
>> +	}
>> +	return 0;
>> +}
>
> Drop the debug messages?
>
> I can't say much about the HW details, of course. Didn't spot anything
> suspicious there.
>
