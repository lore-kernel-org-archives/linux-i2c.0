From: Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Subject: RE: [PATCH v4] i2c: davinci: Fix race when setting up for TX
Date: Thu, 7 Oct 2010 09:39:31 +0100
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE093EE3EA57@Cloud.RL.local>
References: <87wrq3l6m0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <87wrq3l6m0.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

I am not on the i2c list but noticed this pull request:
http://www.spinics.net/linux/lists/linux-i2c/msg04022.html

I think you have the wrong (old) version of this patch in that branch,
http://git.fluff.org/gitweb?p=bjdooks/linux.git;a=commitdiff;h=4bba0fd8d1c6d405df666e2573e1a1f917098be0

The correct v4 one from the start of this thread has more lines
of patch and this commit message:

>>>>> When setting up to transmit, a race exists between the ISR and
>>>>> i2c_davinci_xfer_msg() trying to load the first byte and adjust
>>>>> counters. This is mostly visible for transmits > 1 byte long.
>>>>>
>>>>> The hardware starts sending immediately that MDR.STT is set. IMR
>>>>> trickery doesn't work because if we start sending, finish the
>>>>> first byte and an XRDY event occurs before we load IMR to unmask
>>>>> it, we never get an interrupt, and we timeout.
>>>>>
>>>>> Sudhakar Rajashekhara explains that at least OMAP-L138 requires
>>>>> MDR mode settings before DXR for correct behaviour, so load MDR
>>>>> first with STT cleared and later load again with STT set.
>>>>>
>>>>> Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985
>>>>>
>>>>> Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
>>>>> CC: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
>>>>> CC: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>

It also has some more acks and a tested, via Kevin:

> Acked-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
> Tested-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>


--
Jon Povey
jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
