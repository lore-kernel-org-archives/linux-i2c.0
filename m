From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: Re: [PATCH] axxia-i2c: use auto cmd for last message
Date: Wed, 3 Apr 2019 22:03:20 +0000
Message-ID: <20190403212822.GA29824@localhost.localdomain>
References: <20190328111858.GA17086@localhost.localdomain>
 <20190403205402.dr2uolmpew45xoxd@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403205402.dr2uolmpew45xoxd@ninjato>
Content-Language: en-US
Content-ID: <4AE3D2750551D94AA9766AD6B62EE8DD@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 03, 2019 at 10:54:02PM +0200, Wolfram Sang wrote:
>Hi,
>
>On Thu, Mar 28, 2019 at 11:19:45AM +0000, Adamski, Krzysztof (Nokia - PL/W=
roclaw) wrote:
>> Some recent commits to this driver were trying to make sure the TSS
>> interrupt is not generated on busy system due to 25ms timer expiring
>> between commands. It can still happen, however if STOP command is not
>> issued on time at the end of the transmission. If wait_for_completion in
>> axxia_i2c_xfer_msg() would not return after 25ms of getting an
>> interrupt, TSS will be generated and idev->err_msg will be set to
>> -ETIMEDOUT which will be returned from the axxia_i2c_xfer_msg(), even
>> though the transfer did actually succeed (STOP is automatically issued
>> when TSS triggers).
>>
>> Fortunately, apart from already used manual and sequence commands, the
>> controller also has so called auto command. It works just like manual
>> mode but it but an automatic STOP is issued when either transfer length
>> is met or NAK is received from slave device.
>>
>> This patch changes the axxia_i2c_xfer_msg() function so that auto
>> command is used for last message in transaction letting hardware manage
>> issuing STOP. TSS is disabled just after command transferring last
>> message finishes. Auto command, just like sequence, ends with SS
>> interrupt instead of SNS so handling of both had to be unified.
>>
>> The axxia_i2c_stop() is no longer needed as the transfer can only end
>> with following conditions:
>> - fully successful - then last message was send by AUTO command and STOP
>>   was issued automatically
>> - NAK received - STOP is issued automatically by controller
>> - arbitration lost - STOP should not be issued as we don't control the
>>   bus
>> - IP interrupt received - this is sent when transfer length is set to 0
>>   for auto/sequence command. The check for that is done before START is
>>   send so no STOP is required
>> - TSS received between commands - STOP is issued by the controller
>
>I am not sure. Is this a bugfix (=3D for-current) or more a new feature (=
=3D
>for-next)?

Good question. I wouldn't say it is a clear bugfix and I think it would
require more creativity to justify this as a bugfix than a feature. So I
would go feature route. I might have based that in for-current, indeed
but I think it should be easily applicable on for-next as well. Or do
you want me to resubmit?

>
>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>
>I trust you that Alexander gave the review, but it would be a tad more
>'open development' if he could give it as a reply to your patch on the
>mailing list.

Fair enough. To explain myself - the patch was first reviewed and tested
inhouse before submitting it here - this is where this Reviewed-by comes
from. But lets Alexander confirm that officially.

Best regards,
Krzysztof Adamski
