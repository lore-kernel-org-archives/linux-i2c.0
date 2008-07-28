From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: New Style I2C Driver : how to get clients ?
Date: Mon, 28 Jul 2008 13:35:36 +0300
Message-ID: <31e679430807280335n123cfefen2ac1b9e98d4f6120@mail.gmail.com>
References: <1216903949.48887b0dd2039@imp.free.fr>
	<1216909598.4888911eb6cea@imp.free.fr>
	<31e679430807241126l5bcea400ieafcfa082d11783a@mail.gmail.com>
	<1216976458.4889964a5d9e2@imp.free.fr>
	<1216994898.4889de52becd3@imp.free.fr>
	<31e679430807250726n3e4b189ehcff5dd02f46872f3@mail.gmail.com>
	<1216996221.4889e37d41fa3@imp.free.fr>
	<1217237786.488d931ac5b9b@imp.free.fr>
	<31e679430807280259s67f28aeem8e35e0cf80de35e2@mail.gmail.com>
	<1217239920.488d9b70baec7@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1217239920.488d9b70baec7-HZaT1/I6gcdWj0EZb7rXcA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: fuhz-GANU6spQydw@public.gmane.org
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Mon, Jul 28, 2008 at 1:12 PM,  <fuhz-GANU6spQydw@public.gmane.org> wrote:
> Hi,
>
>> > I read that __i2c_first_dynamic_bus_num is set to 1.
>> > It does not seems to change.
>>
>> it changes in i2c-boardinfo.c@i2c_register_board_info:
>>
>>       /* dynamic bus numbers will be assigned after the last static one */
>>       if (busnum >= __i2c_first_dynamic_bus_num)
>>               __i2c_first_dynamic_bus_num = busnum + 1;
>>
>> which would make the above if() true :-)
>
> You're right !
>
>
>> hmm.. i suppose your calling i2c_register_board_info() with wrong
>> parameters.
>
>> just a note, the first i2c bus is bus 1 and not bus 0. I suppose
>> that's not your problem, right ?
>
> It was :D
> I thought it was zero-based counter...and I tested the code with only one bus !
>
> Hehe, I feel stupid :D
>
>
>
> MANY MANY MANY THANKS :D

Cool. At least it's solved :-)

Have fun now ;-)

-- 
Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
