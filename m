From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH RESEND] i2c: mux: pca954x: simplify code to reach the
 adapter
Date: Mon, 1 Oct 2018 22:44:17 +0200
Message-ID: <5626f9c0-129a-8162-f9b3-ef95c3c835be@lucaceresoli.net>
References: <20180926083534.21999-1-lucaceresoli77@gmail.com>
 <14ba57eb-0647-5dca-8f84-eaa27fd0af4a@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14ba57eb-0647-5dca-8f84-eaa27fd0af4a@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Luca Ceresoli <lucaceresoli77@gmail.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

thanks for the review.

On 01/10/2018 13:49, Peter Rosin wrote:
> On 2018-09-26 10:35, Luca Ceresoli wrote:
>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>
>> struct i2c_client has a direct pointer to the adapter, no need to dig
>> it out of the struct device tree.
> 
> Right, looks sane, but can you please also do the same thing for the
> ltc4306 and mlxcpld drivers which have the same pattern?

No problem. But be aware I can't runtime test these two drivers.

-- 
Luca
