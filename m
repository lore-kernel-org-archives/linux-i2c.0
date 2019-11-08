From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [RFC PATCH 01/12] i2c: replace i2c_new_probed_device with an
 ERR_PTR variant
Date: Fri, 8 Nov 2019 09:01:40 +0100
Message-ID: <9a7efd33-8a7e-1e2e-11f8-64c2ab900a4c@lucaceresoli.net>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-2-wsa+renesas@sang-engineering.com>
 <cd25c799-bb10-aa59-8705-b079eff2165e@lucaceresoli.net>
 <20191107192236.GA961@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107192236.GA961@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 07/11/19 20:22, Wolfram Sang wrote:
> Hi Luca,
> 
>> I beg your pardon for the newbie question, perhaps a stupid one, kind of
>> nitpicking, and not even strictly related to this patch, but what's the
>> reason for these functions being declared extern?
> 
> I did this for consistency reasons. I agree that the 'extern' keyword
> could need some second thought, yet I think that should be a seperate
> patchset. And that does not have priority for me, so if someone is
> interested... :)

Ok, got it!

And then:
Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

Bye,
-- 
Luca
