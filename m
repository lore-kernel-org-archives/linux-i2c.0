From: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Subject: Re: [PATCH] i2c-davinci: Handle signals gracefully
Date: Sat, 24 May 2014 13:53:53 +0200
Message-ID: <53808851.7060308@topic.nl>
References: <1389265885-26777-1-git-send-email-mike.looijmans@topic.nl>
	<1394779348-4084-1-git-send-email-mike.looijmans@topic.nl>
	<20140324161432.GA7524@katana> <20140521081727.GE2708@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20140521081727.GE2708@katana>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 05/21/2014 10:17 AM, Wolfram Sang wrote:
>
>>>   		dev_err(dev->dev, "controller timed out\n");
>>>   		davinci_i2c_recover_bus(dev);
>>>   		i2c_davinci_init(dev);
>>> @@ -384,7 +384,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>>>   	if (dev->buf_len) {
>>>   		/* This should be 0 if all bytes were transferred
>>>   		 * or dev->cmd_err denotes an error.
>>> -		 * A signal may have aborted the transfer.
>>>   		 */
>>>   		if (r >= 0) {
>>>   			dev_err(dev->dev, "abnormal termination buf_len=%i\n",
>>> @@ -436,22 +435,24 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>>>   	ret = i2c_davinci_wait_bus_not_busy(dev, 1);
>>>   	if (ret < 0) {
>>>   		dev_warn(dev->dev, "timeout waiting for bus ready\n");
>>> -		return ret;
>>> +		goto error;
>>
>> You are fixing the error path here to include the completion? This is a
>> seperate patch IMO.
>
> Is my remark true? I still prefer the seperate patch, but we may also
> simply update the commit message.

Your remarks is correct. All your remarks were. Problem currently is 
that I'm not assigned to a project related to the davinci so I cannot 
spend time to fix and port it (the actual platform still runs 2.6.37).

Feel free to adap my patch or comments and commit. Or wait a few weeks 
for when I have a sponsor to split and update the patch.

-- 
Mike Looijmans
