From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: need soem help realter to I2C client
Date: Fri, 19 Sep 2008 14:42:31 +0200
Message-ID: <20080919144231.780fb37a@hyperion.delvare>
References: <697640.78220.qm@web95212.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <697640.78220.qm-4UY5Ii0Ri9vS1Wi2ZBor9F5cfvJIxWXgQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: kalhan trisal <kalhantrisal-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Kalhan,

On Fri, 19 Sep 2008 12:03:56 +0530 (IST), kalhan trisal wrote:
> Hello, 
>    I have platform which has 5 hw devices and I want single driver
> to control all the devices.

Bad idea. This will make your code non-reusable, meaning that nobody
will be interested in it.

> I donot need probe as I know the devices are present and I know all
> the slave address. The interface for read write is using sysfs and
> I am planning to put it under hwmon. These all devices are separate
> chips.
> 
>    Can I do this please let me know.
> 
> 
>  struct foo_data { 
>     struct i2c_client client_data[5]; 
>    }; 
> 
> int foo_detect_client(struct i2c_adapter *adapter, int address,  
>                          unsigned short flags, int kind) 

This interface is deprecated, so no new driver will be allowed to use
it. Please use the (new) standard .probe() method instead.

> { 
>      int err = 0; 
>      int i; 
>      int addrtemp[]= {0x42,0x45,0x46,0x47,0x48};
>      struct i2c_client *new_client; 
>      struct foo_data *data; 
>      const char *client_name = "";
>      
>       For(i=0;i<5;i++)
>       {

You will have to fix your coding style as well.

>            new_client = &data->client_data[i];
>            new_client->addr = addrtemp[i]; 
>            new_client->data = data; //lets consider it is same 
>            new_client->adapter = adapter; 
>            new_client->driver = &foo_driver; 
>            new_client->flags = 0; 
>      
>            strcpy(new_client->name,client_name); 
>           /* Tell the i2c layer a new client has arrived */ 
>           if ((err = i2c_attach_client(new_client))) 
>       }
> }

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
