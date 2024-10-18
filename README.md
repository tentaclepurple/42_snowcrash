## CONFIGUAR EL SSH PARA LA MAQUINA VIRTUAL

1. Tools -> Nertwork -> Host-only Network -> Create+, creas una red llamada vboxnet0
    ![Imagen 1](https://github.com/tentaclepurple/42_snowcrash/blob/main/img/image%20(2).png)
2. En la terminal escribes ip a, te saldra una lista de redes de tu PC en una de ellas se llamara vboxnet0, no tendra una ip asignada.
3. En la VM, en la maquina que has creado, en Setting -> Network -> Adapter 2, añades vboxnet0.
    ![Imagen 2](https://github.com/tentaclepurple/42_snowcrash/blob/main/img/image%20(1).png)
4. Inicias tu maquina virtual, te dara un error, no te preocupes, cierra, ahora en la termina pon ip a, vboxnet0 tendra un ip asignada.
5. Vamos a  Adapter 1 y en Advanced tiene un triangulo azul, lo clicamos y vamos a Port Forwarding y en Host ip, colocas tu ip de vboxnet0, todo lo demas igual que en la foto.
    ![Imagen 3](https://github.com/tentaclepurple/42_snowcrash/blob/main/img/image.png)
6. Si todo es correcto te saldra esta imagen
   ![Imagen 4](https://github.com/tentaclepurple/42_snowcrash/blob/main/img/image%20(3).png)
