From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 6/8]i2c:i2c_core Fix warning: variable 'dummy' set but
  not used
Date: Tue, 15 Jun 2010 09:51:36 -0700
Message-ID: <4C17AF98.3020307@gmail.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com>	<1276547208-26569-7-git-send-email-justinmattock@gmail.com>	<20100614225315.2bae9e37@hyperion.delvare>	<4C1699C4.3010809@gmail.com> <20100615134343.6ae4a6e1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100615134343.6ae4a6e1@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-bluetooth@vger.kernel.org, clemens@ladisch.de, debora@linux.vnet.ibm.com, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 06/15/2010 04:43 AM, Jean Delvare wrote:
> Hi Justin,
>
> On Mon, 14 Jun 2010 14:06:12 -0700, Justin P. Mattock wrote:
>> On 06/14/2010 01:53 PM, Jean Delvare wrote:
>>> Hi Justin,
>>>
>>> On Mon, 14 Jun 2010 13:26:46 -0700, Justin P. Mattock wrote:
>>>> could be a right solution, could be wrong
>>>> here is the warning:
>>>>     CC      drivers/i2c/i2c-core.o
>>>> drivers/i2c/i2c-core.c: In function 'i2c_register_adapter':
>>>> drivers/i2c/i2c-core.c:757:15: warning: variable 'dummy' set but not used
>>>>
>>>>    Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>>>>
>>>> ---
>>>>    drivers/i2c/i2c-core.c |    2 ++
>>>>    1 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>>> index 1cca263..79c6c26 100644
>>>> --- a/drivers/i2c/i2c-core.c
>>>> +++ b/drivers/i2c/i2c-core.c
>>>> @@ -794,6 +794,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>>>>    	mutex_lock(&core_lock);
>>>>    	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
>>>>    				 __process_new_adapter);
>>>> +	if(!dummy)
>>>> +		dummy = 0;
>>>
>>> One word: scripts/checkpatch.pl
>>
>> it was this, and/or just take the code out
>> (since I'm a newbie)
>
> I was not (yet) arguing on the code itself, but on its format. Any
> patch you send should pass the formatting tests performed by
> scripts/checkpatch.pl. Thanks.
>


o.k.  I'll make sure I run everything through checkpatch.pl before 
sending anything.

Justin P. Mattock
