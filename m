From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 7/8]ieee1394/sdp2 Fix warning: variable
	'unit_characteristics' set but not used
Date: Tue, 15 Jun 2010 09:52:51 -0700
Message-ID: <4C17AFE3.6080007@gmail.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com>	<1276547208-26569-8-git-send-email-justinmattock@gmail.com>
	<20100615133830.55afdddf@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100615133830.55afdddf@hyperion.delvare>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, reiserfs-devel@vger.kernel.org, linux-bluetooth@vger.kernel.org, debora@linux.vnet.ibm.com, linux-i2c@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 06/15/2010 04:38 AM, Jean Delvare wrote:
> On Mon, 14 Jun 2010 13:26:47 -0700, Justin P. Mattock wrote:
>> Temporary fix until something is resolved
>
> This is wrong by design, sorry. Warnings aren't blocking, and thus need
> no "temporary fix". Such temporary fixes would be only hiding the
> warning, cancelling the good work of gcc developers. Nack nack nack.
>

o.k.

>> to fix the below warning:
>>    CC [M]  drivers/ieee1394/sbp2.o
>> drivers/ieee1394/sbp2.c: In function 'sbp2_parse_unit_directory':
>> drivers/ieee1394/sbp2.c:1353:6: warning: variable 'unit_characteristics' set but not used
>>   Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>>
>> ---
>>   drivers/ieee1394/sbp2.c |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
>> index 4565cb5..fcf8bd5 100644
>> --- a/drivers/ieee1394/sbp2.c
>> +++ b/drivers/ieee1394/sbp2.c
>> @@ -1356,6 +1356,8 @@ static void sbp2_parse_unit_directory(struct sbp2_lu *lu,
>>
>>   	management_agent_addr = 0;
>>   	unit_characteristics = 0;
>> +	if (!unit_characteristics)
>> +		unit_characteristics = 0;
>>   	firmware_revision = SBP2_ROM_VALUE_MISSING;
>>   	model = ud->flags&  UNIT_DIRECTORY_MODEL_ID ?
>>   				ud->model_id : SBP2_ROM_VALUE_MISSING;
>
>

Thanks for the response and info on this.

Justin P. Mattock

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
