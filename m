From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] i2c: Push ioctl BKL down into the i2c code
Date: Fri, 23 May 2008 20:08:37 +0200
Message-ID: <48370825.9070304@s5r6.in-berlin.de>
References: <20080522222327.1af72794@core>	<20080523093545.175c769c@hyperion.delvare>	<48368466.5040600@s5r6.in-berlin.de> <20080523195302.42846394@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758634AbYEWSJB@vger.kernel.org>
In-Reply-To: <20080523195302.42846394@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> On Fri, 23 May 2008 10:46:30 +0200, Stefan Richter wrote:
>> AFAIU it's a preparation for
>> 
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ ?? @@ struct file_operations {
>>  	unsigned int (*poll) (struct file *, struct poll_table_struct *);
>> -	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
>>  	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
>>
>> Obvious benefits:
>>   - No new .ioctl()s.
> 
> I fail to see how this is related to the locking change.

I meant:  After struct file_operations.ioctl is removed, developers can 
only implement unlocked_ioctl methods.  This includes code that is not 
(yet) in mainline.  To keep it compilable, it has to be converted to 
unlocked_ioctl.

[The quickest kind of conversion is to replace the ioctl method by an 
unlocked_ioctl method which itself takes the BKL.  This kind of 
conversion has of course no direct benefit for the functioning of the 
kernel, but as mentioned it at least puts the BKL issue into the line of 
sight of the people who work with the code.]
-- 
Stefan Richter
-=====-==--- -=-= =-===
http://arcgraph.de/sr/
