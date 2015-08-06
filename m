From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 4/4] i2c: arb-gpio-challenge: use of_get_i2c_adapter_by_node
 interface
Date: Thu, 6 Aug 2015 13:18:55 +0300
Message-ID: <55C3348F.7030801@mentor.com>
References: <1438007451-8553-1-git-send-email-vladimir_zapolskiy@mentor.com> <1438007451-8553-5-git-send-email-vladimir_zapolskiy@mentor.com> <20150806005151.GD1743@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150806005151.GD1743@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 06.08.2015 03:51, Wolfram Sang wrote:
> On Mon, Jul 27, 2015 at 05:30:51PM +0300, Vladimir Zapolskiy wrote:
>> This change is needed to properly lock I2C parent bus driver.
>>
>> Prior to this change i2c_put_adapter() is misused, which may lead
>> to an overflow over zero of I2C bus driver user counter.
>>
>> By the way added a missing of_node_put() to eliminate memory leak,
>> if OF_DYNAMIC is enabled.
>>
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>> Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> 
> Applied to for-next! However...

great, thank you.

>> +	of_node_put(parent_np);
> 
> I removed this line. Please resend this as a seperate patch since it
> fixes a seperate issue.
> 

Definitely, I always forget about non-zero probability of any commit
reverse. I'll resend this change plus at least two more similar fixes in
drivers/i2c I have in mind in a separate series.

--
With best wishes,
Vladimir
