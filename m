From: Luca Ceresoli <lucaceresoli77@gmail.com>
Subject: Re: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
Date: Wed, 10 Oct 2018 17:48:20 +0200
Message-ID: <70c48ade-b2ac-dde8-4b3e-aa4b2f19940a@gmail.com>
References: <20181003151928.17713-1-lucaceresoli77@gmail.com>
 <99cfa6a2-9a60-6bdd-2542-9dd78af75758@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <99cfa6a2-9a60-6bdd-2542-9dd78af75758@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On 08/10/2018 23:43, Peter Rosin wrote:
> On 2018-10-03 17:19, Luca Ceresoli wrote:
>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>
>> i2c-mux instantiates one i2c_algorithm for each downstream adapter.
>> However these algorithms are all identical, depending only on the
>> parent adapter.
>>
>> Avoid duplication by hoisting the i2c_algorithm from the adapters to
>> the i2c_mux_core object, and reuse it in all the adapters.
> 
> Ouch, while I like the concept of having one i2c_algorithm per mux,
> this patch is not working. Various i2c-mux drivers set the
> muxc->mux_locked variable *after* the i2c_mux_alloc call, and this
> patch breaks such use.
> 
> So, the patch needs some reworking. Sorry for not noticing this
> earlier.

Thanks for the heads up.

3 drivers have the issue you mentioned, and two of them are not trivial
to fix. Ok, as soon as I can spend a little time on this I'll have a
look and hopefully send a fixed patch.

Regards,
-- 
Luca
