From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 4/8]drivers:tmp.c Fix warning: variable 'rc' set but not
	used
Date: Mon, 14 Jun 2010 19:12:31 -0700
Message-ID: <4C16E18F.9050901@gmail.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com>
	<1276547208-26569-5-git-send-email-justinmattock@gmail.com>
	<21331.1276560832@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <21331.1276560832@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, reiserfs-devel@vger.kernel.org, linux-bluetooth@vger.kernel.org, debora@linux.vnet.ibm.com, linux-i2c@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 06/14/2010 05:13 PM, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 14 Jun 2010 13:26:44 PDT, "Justin P. Mattock" said:
>> Im getting this warning when compiling:
>>   CC      drivers/char/tpm/tpm.o
>> drivers/char/tpm/tpm.c: In function 'tpm_gen_interrupt':
>> drivers/char/tpm/tpm.c:508:10: warning: variable 'rc' set but not used
>>
>> The below patch gets rid of the warning,
>> but I'm not sure if it's the best solution.
>
>>   	rc = transmit_cmd(chip,&tpm_cmd, TPM_INTERNAL_RESULT_SIZE,
>>   			"attempting to determine the timeouts");
>> +	if (!rc)
>> +		rc = 0;
>>   }
>
> Good thing that's a void function. ;)
>
> Unless transmit_cmd() is marked 'must_check', maybe losing the 'rc =' would
> be a better solution?


what I tried was this:

if (!rc)
	printk("test........"\n")

and everything looked good,
but as a soon as I changed

rc = transmit_cmd(chip,&tpm_cmd, TPM_INTERNAL_RESULT_SIZE,
    			"attempting to determine the timeouts");

to this:

rc = transmit_cmd(chip,&tpm_cmd, TPM_INTERNAL_RESULT_SIZE);

if (!rc)
	printk("attempting to determine the timeouts\n");

I error out with transmit_cmd not having enough
functions to it.. so I just added the rc = 0;
and went on to the next.

Justin P. Mattock

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
