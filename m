From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH AUTOSEL 5.5 495/542] docs: i2c: writing-clients: properly
 name the stop condition
Date: Sun, 16 Feb 2020 22:49:39 +0100
Message-ID: <dfb3d313-ad9e-8f53-a7f6-d3bfe655d493@lucaceresoli.net>
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-495-sashal@kernel.org>
 <20200215071402.027c9120@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200215071402.027c9120@endymion>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 15/02/20 07:14, Jean Delvare wrote:
> On Fri, 14 Feb 2020 10:48:07 -0500, Sasha Levin wrote:
>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>
>> [ Upstream commit 4fcb445ec688a62da9c864ab05a4bd39b0307cdc ]
>>
>> In I2C there is no such thing as a "stop bit". Use the proper naming: "stop
>> condition".
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> Reported-by: Jean Delvare <jdelvare@suse.de>
>> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  Documentation/i2c/writing-clients.rst | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
>> index ced309b5e0cc8..3869efdf84cae 100644
>> --- a/Documentation/i2c/writing-clients.rst
>> +++ b/Documentation/i2c/writing-clients.rst
>> @@ -357,9 +357,9 @@ read/written.
>>  
>>  This sends a series of messages. Each message can be a read or write,
>>  and they can be mixed in any way. The transactions are combined: no
>> -stop bit is sent between transaction. The i2c_msg structure contains
>> -for each message the client address, the number of bytes of the message
>> -and the message data itself.
>> +stop condition is issued between transaction. The i2c_msg structure
>> +contains for each message the client address, the number of bytes of the
>> +message and the message data itself.
>>  
>>  You can read the file ``i2c-protocol`` for more information about the
>>  actual I2C protocol.
> 
> I wouldn't bother backporting this documentation patch to stable and
> longterm trees. That's a minor vocabulary thing really, it does not
> qualify.

I also feel no need to have it in stable branches. Hovever it would not
hurt, so whatever is fine for who's maintaining that branch will be fine
for me as well.

-- 
Luca
